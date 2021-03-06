# frozen_string_literal: true

module ActionTextHelper
  def fill_in_rich_text_area(locator = nil, with:)
    find(:rich_text_area, locator).execute_script('this.editor.loadHTML(arguments[0])', with.to_s)
  end
end

Capybara.add_selector :rich_text_area do
  label '内容'
  xpath do |locator|
    if locator.nil?
      XPath.descendant(:"trix-editor")
    else
      input_located_by_name = XPath.anywhere(:input).where(XPath.attr(:name) == locator).attr(:id)

      XPath.descendant(:"trix-editor").where \
        XPath.attr(:id).equals(locator) |
        XPath.attr(:placeholder).equals(locator) |
        XPath.attr(:"aria-label").equals(locator) |
        XPath.attr(:input).equals(input_located_by_name)
    end
  end
end
