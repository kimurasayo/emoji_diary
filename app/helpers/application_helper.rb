module ApplicationHelper
  include Pagy::Frontend

  def page_title(page_title = '')
    base_title = "emory"
    if page_title.empty?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end

  # twitter OGP
  def default_meta_tags
    {
      title:       "emory",
      description: "絵文字だけを使って日記をつけてみませんか？",
      keywords:    "emoji,diary",
      icon: [
        # { href: image_url('favicon.ico') },
        # { href: image_url('sample.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      noindex: ! Rails.env.production?,
      canonical: request.original_url,
      charset: "UTF-8",
      # OGPの設定
      og: {
        title: "emory",
        description: "絵文字だけを使って日記をつけてみませんか？",
        type: "website",
        url: request.original_url,
        image: asset_pack_url("media/images/LINE.png"),
        site_name: "emory",
        locale: "ja_JP"
      },
      twitter: {
        site: '@sayo_saru',
        card: 'summary_large_image',
        image: asset_pack_url('media/images/twitter_share.png')
      },
      fb: {
        #app_id: ''
      }
    }
  end
end
