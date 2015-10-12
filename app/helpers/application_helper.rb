module ApplicationHelper
  require 'redcarpet'
#  require 'rouge'
#  require 'rouge/plugins/redcarpet'
  
  class HTML < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
  end

  def markdown(content)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, {
#      linebreak:           true,
      autolink:            true,
      space_after_headers: true,
      fenced_code_blocks:  true,
      superscript:         true,
      underline:           true,
      highlight:           true,
      footnotes:           true,
      quote:               true,
      tables:              true
    })
    @markdown.render(content).html_safe
#    content.html_safe
  end

  def gravatar_url size=32
    "http://www.gravatar.com/avatar/c1873b0d2c86671bb1b3d44b53b48c09.png?s=#{size}"
  end
=begin
  def markdown(text)
    render_options = {
#      filter_html:     true,
      hard_wrap:       true, 
      link_attributes: { rel: 'nofollow' },
      line_numbers:    true,
      wrap:            true
    }
    renderer = HTML.new(render_options)

    extensions = {
      autolink:           true,
      fenced_code_blocks: true,
      lax_spacing:        true,
      no_intra_emphasis:  true,
      strikethrough:      true,
      superscript:        true
    }
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
#    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
#    Redcarpet.new(text, *options).to_html.html_safe
  end
=end
end
