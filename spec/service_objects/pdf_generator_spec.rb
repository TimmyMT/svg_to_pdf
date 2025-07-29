require 'rails_helper'

RSpec.describe PdfGenerator do
  let(:svg_path) { Rails.root.join('spec', 'fixtures', 'ruby.svg') }
  let(:service) { described_class.new(svg_path: svg_path) }

  describe '.call' do
    it 'generates pdf file' do
      pdf_path = service.call

      expect(File).to exist(pdf_path)
      expect(File.read(pdf_path)).to start_with('%PDF')
    end

    it 'includes the watermark text' do
      pdf_path = described_class.new(svg_path: svg_path).call

      reader = PDF::Reader.new(pdf_path)
      actual_chars = reader.pages.map(&:text).join.gsub(/\s+/, '').chars.sort

      expect(actual_chars).to match(%w[K T i m o r u])
    end
  end
end
