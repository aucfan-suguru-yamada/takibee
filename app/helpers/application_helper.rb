module ApplicationHelper
  def active_if(*path)
    active_menu?(*path) ? 'active-nav-item text-dark' : ''
  end

  def active_menu?(*path)
    path.any? { |c| c == controller_path }
  end

  def before_login_active_if(path, action)
    path == controller_path && action == action_name ? 'active-nav-item text-dark' : ''
  end

  # meta-tagの設定
  def default_meta_tags
    {
      site: 'TAKiBEE.',
      title: 'TAKiBEE.',
      reverse: true,
      charset: 'utf-8',
      description: 'キャンプを記録するサービスです。キャンプ地・アイテム・写真の記録を残そう。',
      keywords: 'TAKiBEE,キャンプ,キャンプギア,キャンプアイテム',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('apple-touch-icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' }
      ],
      og: {
        site_name: :site, # もしくは site_name: :site
        title: 'TAKiBEE.', # もしくは title: :title
        description: :description, # もしくは description: :description
        type: 'website',
        url: request.original_url,
        image: image_url('takibee_icon.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary',
        site: '@Soogle_1729'
      }
    }
  end
end
