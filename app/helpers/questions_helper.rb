module QuestionsHelper
  def content_sumnail(content)
    if content.length > 100
      "#{content[..99]}..."
    else
      content
    end
  end
end
