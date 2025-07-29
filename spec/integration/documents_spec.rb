require 'swagger_helper'

RSpec.describe 'Documents API', type: :request do
  path '/api/v1/documents' do
    post 'Upload SVG and generate PDF' do
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :file, in: :formData, type: :file, description: 'SVG file to upload'

      response '201', 'document created' do
        schema type: :object,
        properties: {
          id: { type: :integer },
          name: { type: :string },
          pdf_url: { type: :string, format: :uri }
        },
        required: ['id', 'name', 'pdf_url']

        let(:file) { fixture_file_upload('spec/fixtures/ruby.svg', 'image/svg+xml') }

        run_test! do
          expect(JSON.parse(response.body)['name']).to eq("ruby.svg")
          expect(Document.count).to eq(1)
          expect(Document.last.pdf_file.present?).to eq(true)
          expect(Document.last.pdf_file.attached?).to eq(true)
          expect(Document.last.pdf_file.record.name).to eq("ruby.svg")
        end
      end

      response '400', 'bad request' do
        let(:file) { nil }
        run_test!
      end

      response '415', 'unsupported media type' do
        let(:file) { fixture_file_upload('spec/fixtures/ruby.svg', 'text/plain') }
        run_test!
      end
    end
  end
end
