require 'rouge/plugins/redcarpet'

class MarkdownService
  class Renderer < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
    protected
    def rouge_formatter(opts = {})
      options = { 
        css_class:    'highlight', 
        line_numbers: true }
      Rouge::Formatters::HTML.new options
    end
  end

  attr_reader :markdown

  def self.call(markdown)
    new(markdown).call
  end

  def initialize(markdown)
    @markdown = markdown
  end

  def call
    render
  end

  private
  def markdown_renderer
    options = {
      autolink:           true, 
      tables:             true,
      fenced_code_blocks: true }
    Redcarpet::Markdown.new(Renderer, options)
  end

  def render
    markdown_renderer.render(markdown).html_safe
  end
end
