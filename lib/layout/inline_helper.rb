module Layout
  # Module for layout
  module InlineHelper
    def b(value, styles = {})
      css = serialize text(styles)
      content_tag(:b, value, style: css)
    end

    def span(value, styles = {})
      css = serialize text(styles)
      content_tag(:span, value, style: css)
    end

    def div(value, styles = {})
      css = serialize text(styles)
      content_tag(:div, value, style: css)
    end

    def td(styles = {})
      css = serialize table_cell(styles)
      content_tag(:td, valign: 'top', style: css) { yield }
    end

    def icon(label)
      image_tag "#{label}.png", alt: label, nosend: 1, border: 0,
                                style: 'opacity: 0.7;'
    end

    def link_to_icon(label, url)
      link_to icon(label), url, style: text_styles('color' => '#333333')
    end

    def td_styles(styles = {})
      styles['padding-top']    ||= '0px'
      styles['padding-right']  ||= '0px'
      styles['padding-bottom'] ||= '0px'
      styles['padding-left']   ||= '0px'
      styles['text-align']     ||= 'left'
      serialize(styles)
    end

    private

    def serialize(styles = {})
      styles.each_with_object('') do |(name, value), style|
        style + "#{name}: #{value};"
      end
    end

    def text_styles(styles = {})
      styles['color']       ||= '#000000'
      styles['font-family'] ||= "'Verdana'"
      styles['font-size']   ||= '10pt'
      styles['text-align']  ||= 'left'
      serialize styles
    end

    def text(styles = {})
      styles['color']       ||= '#000000'
      styles['font-family'] ||= "'Verdana', sans-serif"
      styles['font-size']   ||= '10pt'
      styles['text-align']  ||= 'left'
      styles
    end

    def table_cell(styles = {})
      styles['padding-top']    ||= '0px'
      styles['padding-right']  ||= '0px'
      styles['padding-bottom'] ||= '0px'
      styles['padding-left']   ||= '0px'
      styles['text-align']     ||= 'left'
      styles
    end
  end
end
