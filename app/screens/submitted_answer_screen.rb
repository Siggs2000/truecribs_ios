class SubmittedAnswerScreen < PM::Screen
  title "Answer Submitted"
  stylesheet SubmittedAnswerScreenStylesheet

  def on_load
    @submitted_label = append!(UILabel, :submitted_label)
    check_game_status
  end

  def check_game_status
    timer = EM.add_periodic_timer 3.0 do
      BW::HTTP.get("#{API_URL}/games/#{App::Persistence['game_id']}", {payload: @data}) do |response|
        p response
        if response.ok?
          mp json = BW::JSON.parse(response.body)
          game = json['result']
          if App::Persistence['question_count'] == game['stage']
            EM.cancel_timer(timer)
            app_delegate.get_question(App::Persistence['question_count'])
          end
        else
          open GameSelectScreen.new(nav_bar: false)
        end
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
