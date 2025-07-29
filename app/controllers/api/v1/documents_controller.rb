class Api::V1::DocumentsController < ApplicationController
  before_action :file_present?
  before_action :valid_file_type?

  def create
    document = Document.new(name: params[:file].original_filename)

    begin
      pdf_path = PdfGenerator.new(svg_path: params[:file].tempfile.path).call
      document.save!
      document.pdf_file.attach(
        io: File.open(pdf_path),
        filename: File.basename(pdf_path),
        content_type: "application/pdf"
      )

      render json: document, status: :created
    rescue StandardError => e
      Rails.logger.error("PDF generation or attachment failed: #{e.message}")
      render_error("Failed to generate or attach PDF", :unprocessable_entity)
    end
  end

  private

  def file_present?
    unless params[:file].present?
      render_error("Failed to generate or attach PDF", :bad_request)
    end
  end

  def valid_file_type?
    if params[:file].content_type != "image/svg+xml"
      render_error("Only SVG files are allowed", :unsupported_media_type)
    end
  end

  def render_error(message, status)
    render json: { error: message }, status: status
  end
end
