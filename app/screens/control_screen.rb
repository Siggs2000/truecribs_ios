class ControlScreen < PM::Screen
  title "Let's Play!"
  stylesheet ControlScreenStylesheet

  def on_load
    @choice_one_button = append!(UIButton, :choice_one_button).on(:touch) { choice_one }
    @choice_one_button = append!(UIButton, :choice_two_button).on(:touch) { choice_two }
    @choice_one_button = append!(UIButton, :choice_three_button).on(:touch) { choice_three }
    @choice_one_button = append!(UIButton, :choice_four_button).on(:touch) { choice_four }
  end

  def choice_one
    mp "choice_one"
    answer_id = Answer.where(:body).eq(App::Persistence['choice_1']).first.api_id
    send_answer(answer_id)
  end

  def choice_two
    mp "choice_two"
    answer_id = Answer.where(:body).eq(App::Persistence['choice_2']).first.api_id
    send_answer(answer_id)
  end

  def choice_three
    mp "choice_three"
    answer_id = Answer.where(:body).eq(App::Persistence['choice_3']).first.api_id
    send_answer(answer_id)
  end

  def choice_four
    mp "choice_four"
    answer_id = Answer.where(:body).eq(App::Persistence['choice_4']).first.api_id
    send_answer(answer_id)
  end

  def send_answer(answer_id)
    @data = {user_id: App::Persistence['user_id'], answer_id:answer_id }
    mp @data
    BW::HTTP.post("#{API_URL}/guesses", {payload: @data}) do |response|
      p response
      if response.ok?
        mp json = BW::JSON.parse(response.body)
        #open ControlScreen.new(nav_bar:true)
        App::Persistence['question_count'] = App::Persistence['question_count'] + 1
        open SubmittedAnswerScreen.new(nav_bar:false)
      else
        # open GameSelectScreen.new(nav_bar: false)
      end
    end
  end

  # You don't have to reapply styles to all UIViews, if you want to optimize, another way to do it
  # is tag the views you need to restyle in your stylesheet, then only reapply the tagged views, like so:
  #   def logo(st)
  #     st.frame = {t: 10, w: 200, h: 96}
  #     st.centered = :horizontal
  #     st.image = image.resource('logo')
  #     st.tag(:reapply_style)
  #   end
  #
  # Then in will_animate_rotate
  #   find(:reapply_style).reapply_styles#

  # Remove the following if you're only using portrait
  def will_animate_rotate(orientation, duration)
    reapply_styles
  end
end
