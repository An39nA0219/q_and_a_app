module QuestionsHelper
  def body_sumnail(body)
    if body.length > 100
      "#{body[..99]}..."
    else
      body
    end
  end
end
