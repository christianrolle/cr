# Presents the resume in the view
class ResumePresenter
  def initialize(view)
    @view = view
    yield(self)
  end

  def resume(organization, type)
    text = Resume.translate organization, type
    return if text.blank?
    h.content_tag(:p, class: type) do
      h.content_tag(:span, I18n.t("documents.resume.#{type}")) + text
    end
  end

  private

  def h
    @view
  end
end
