require 'active_support/concern'

module Heraldic
  extend ActiveSupport::Concern

  included do
    has_attached_file :heraldry, styles: { thumb: "100x100>" }
    before_post_process :resize_images

    validates_with Paperclip::Validators::AttachmentContentTypeValidator, attributes: :heraldry, content_type: /\Aimage\/.*\Z/
    validates_with Paperclip::Validators::AttachmentSizeValidator, attributes: :heraldry, less_than: 500.kilobytes
  end

  def raster_image?
      heraldry_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end

  def heraldry_thumb_url
    if raster_image?
      return heraldry.url(:thumb)
    else
      return heraldry.url
    end
  end

  def resize_images
    return false unless raster_image?
  end
end
