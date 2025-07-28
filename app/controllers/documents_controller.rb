class DocumentsController < ApplicationController
  def create
    return render_error("SVG file is required", :bad_request) unless file_present?
    return render_error("Only SVG files are allowed", :unsupported_media_type) unless valid_file_type?
    return render_error("File too large (max 5MB)", :payload_too_large) unless valid_file_size?

    document = Document.new(name: params[:file].original_filename)

    begin
      pdf_path = PdfGenerator.new(svg_path: params[:file].tempfile.path).call
      document.save!
      document.pdf_file.attach(
        io: File.open(pdf_path),
        filename: File.basename(pdf_path),
        content_type: "application/pdf"
      )

      render json: DocumentSerializer.new(document).serializable_hash, status: :created
    rescue StandardError => e
      Rails.logger.error("PDF generation or attachment failed: #{e.message}")
      render_error("Failed to generate or attach PDF", :unprocessable_entity)
    end
  end

  private

  def file_present?
    params[:file].present?
  end

  def valid_file_type?
    params[:file].content_type == "image/svg+xml"
  end

  def valid_file_size?
    params[:file].size <= 5.megabytes
  end

  def render_error(message, status)
    render json: { error: message }, status: status
  end
end
