class SignInScreen < PM::XLFormScreen
  title "Sign In"
  stylesheet SignInScreenStylesheet
  form_options on_save: :save_it


  def on_load
    set_nav_bar_button :left, title: "Back", action: :welcome
  end

  def form_data
    [{
      title: "",
      footer: "",
      cells: [{
        name: "email",
        title: "Email",
        type: :email,
        value: "",
      }, {
        name: "password",
        title: "Password",
        type: :password,
        value: ""
      }, {
        name: :submit,
        title: "Submit",
        type: :button,
        on_click: -> (cell) {
          on_save(nil)
        }

      }]
    }]
  end

  # def save_it(values)
  #    dismiss_keyboard
  #    mp on_save: data = values
  #    p data['email']
  #  end

  def save_it(values)
    mp on_save: data = values


    App::Persistence['available'] = false

    p data['email']
    SVProgressHUD.showWithStatus("Signing In...", maskType:SVProgressHUDMaskTypeBlack)
    params = { user: {email: "#{data['email']}", password:"#{data['password']}" }}
    AFMotion::JSON.post("#{BASE_URL}/sessions.json", params) do |result|
      if result.success?
        p result.object
        p "token: #{result.object["data"]["auth_token"]}"
        #App::Persistence['auth_token'] = result.object["data"]["auth_token"]
        App::Persistence['user_id'] = result.object["data"]["user_id"]
        App::Persistence['user_name'] = result.object["data"]["name"]
        App::Persistence['user_email'] = result.object["data"]["email"]

        SVProgressHUD.dismiss
        #send info to Parse for pushes
        #app_delegate.parse_register

        # app_delegate.register_for_push_notifications :badge, :sound, :alert, :newsstand
        # PM.logger.info app_delegate.registered_push_notifications

        open GameSelectScreen.new(nav_bar:false)

        #app_delegate.get_location

      else
        SVProgressHUD.dismiss
        App.alert("Login failed")
        App.alert(result.error.localizedDescription)
      end
    end
  end

  def welcome
    open WelcomeScreen.new
  end
end
