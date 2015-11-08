class AppDelegate < PM::Delegate
  include CDQ # Remove this if you aren't using CDQ

  status_bar true, animation: :fade

  # Without this, settings in StandardAppearance will not be correctly applied
  # Remove this if you aren't using StandardAppearance
  ApplicationStylesheet.new(nil).application_setup

  def on_load(app, options)
    cdq.setup # Remove this if you aren't using CDQ

    if App::Persistence['user_id'].nil?
      open SignInScreen.new(nav_bar: true)
    else
      open GameSelectScreen.new(nav_bar:true)
    end
  end

  def get_question(question_count)
    @data = {game_id: App::Persistence['game_id'], quest_num:question_count }
    BW::HTTP.get("#{API_URL}/questions", {payload: @data}) do |response|
      p response
      if response.ok?
        mp json = BW::JSON.parse(response.body)
        question = json['result']
        App::Persistence['question_id'] = question['id']
        #open ControlScreen.new(nav_bar:true)
        get_answers
      else
        open GameSelectScreen.new(nav_bar: false)
      end
    end
  end

  def get_answers
    Answer.each do |x|
      x.destroy
    end


    @data = {question_id: App::Persistence['question_id'], quest_num:App::Persistence['question_id'] }
    BW::HTTP.get("#{API_URL}/answers", {payload: @data}) do |response|
      p response
      if response.ok?
        p json = BW::JSON.parse(response.body)
        if json['result'].count >= 1
          #p json['result'].first['id']
          @count = 0
          array = Array.new
          json['result'].each do |answer|
            mp answer
            @count = @count + 1
            array << answer['id']
            Answer.create(body:answer['body'], image:answer['image'], api_id:answer['id'])
          end
          first_id = Answer.first.api_id
          App::Persistence['choice_1'] = Answer.where(:api_id).eq(array[0]).first.body
          App::Persistence['choice_2'] = Answer.where(:api_id).eq(array[1]).first.body
          App::Persistence['choice_3'] = Answer.where(:api_id).eq(array[2]).first.body
          App::Persistence['choice_4'] = Answer.where(:api_id).eq(array[3]).first.body
          open ControlScreen.new(nav_bar:true)
        else
          # handle no games available
        end
      else
        open GameSelectScreen.new(nav_bar: false)
      end
    end
  end
  # Remove this if you are only supporting portrait
  def application(application, willChangeStatusBarOrientation: new_orientation, duration: duration)
    # Manually set RMQ's orientation before the device is actually oriented
    # So that we can do stuff like style views before the rotation begins
    device.orientation = new_orientation
  end
end
