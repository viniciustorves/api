module Features
  def selectize(container, option:)
    find("#{container} .selectize-input").click
    find("#{container} #{option}").click
  end
end
