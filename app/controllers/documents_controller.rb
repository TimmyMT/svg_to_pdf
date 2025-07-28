class DocumentsController < ApplicationController
  def create
    svg_path = params[:file].tempfile.path

    PdfGenerator.new(svg_path: svg_path).call
  end
end
