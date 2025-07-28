class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :name, :pdf_url

  def pdf_url
    Rails.application.routes.url_helpers.rails_blob_url(object.pdf_file, only_path: false) if object.pdf_file.attached?
  end
end
