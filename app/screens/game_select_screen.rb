class GameSelectScreen < PM::TableScreen
  title "Join a Game"
  stylesheet GameSelectScreenStylesheet
  refreshable

  def on_load
    get_games
  end

  def table_data
    [{
      cells: Game.map do |game|
        {
          title: game.name,
          subtitle: game.location,
          action: :select_game,
          arguments: { game: game.api_id }
        }
      end
    }]
  end

  def select_game(item)
    game = Game.where(:api_id).eq(item).first
    App::Persistence['game_id'] = game.api_id
    open ControlScreen.new(nav_bar:true)
  end

  def on_refresh
    get_games
  end

  def get_games
    Game.each do |x|
      x.destroy
    end
    headers = { 'Authorization' => "Token token=#{App::Persistence['auth_token']}" }
    #@data = {user_id: App::Persistence['nurse_id'] }
    BW::HTTP.get("#{API_URL}/games", {headers: headers}) do |response|
      p response
      if response.ok?
        p json = BW::JSON.parse(response.body)
        if json['result'].count >= 1
          #p json['result'].first['id']
          json['result'].each do |game|
            p game
            Game.create(name:game['name'], api_id:game['id'].to_i, location:game['location'])
          end
          stop_refreshing
          update_table_data
        else
          # handle no games available
        end
      else
        open GameSelectScreen.new(nav_bar: false)
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
