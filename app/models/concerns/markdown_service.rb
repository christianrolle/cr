# frozen_string_literal: true

# Transforms articles texts into Markdown
class MarkdownService
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
      syntax_highlighter: 'rouge',
      syntax_highlighter_opts: { inline_theme: 'github' },
      coderay_line_numbers: :table
    }
    Kramdown::Document.new(markdown, options)
  end

  def render
    markdown_renderer.to_html
  end
end
