module MetaTagsHelper

  def meta_title
    content_for?(:meta_title) ? content_for(:meta_title) : Setting.first.meta_title
  end

  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) : Setting.first.meta_description
  end

  def meta_image
    meta_image = (content_for?(:meta_image) ? content_for(:meta_image) : DEFAULT_META["meta_image"])
    # little twist to make it work equally with an asset or a url
    meta_image.starts_with?("http") ? meta_image : image_url(meta_image)
  end

  def meta_keywords
    content_for?(:meta_keywords) ? content_for(:meta_keywords) : Setting.first.meta_keywords
  end
  
end