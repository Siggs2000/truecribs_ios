class ControlScreenStylesheet < ApplicationStylesheet
  # Add your view stylesheets here. You can then override styles if needed,
  # example: include FooStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def choice_one_button(st)
    st.background_color = rmq.color('#3BDBF0')
    st.color = color.white
    st.font = font.system(22)
    st.frame         = {grid: "a2:f6"}#{fr: 15, w: (st.superview.size.width - 45)/2, h: 40, t: 80}
    st.corner_radius = 2
    st.text = "#{App::Persistence['choice_1']}"
  end

  def choice_two_button(st)
    st.background_color = rmq.color('#3BDBF0')
    st.color = color.white
    st.font = font.system(22)
    st.frame         = {grid: "g2:l6"}#{fr: 15, w: (st.superview.size.width - 45)/2, h: 40, t: 80}
    st.corner_radius = 2
    st.text = "#{App::Persistence['choice_2']}"
  end

  def choice_three_button(st)
    st.background_color = rmq.color('#3BDBF0')
    st.color = color.white
    st.font = font.system(22)
    st.frame         = {grid: "a9:f13"}#{fr: 15, w: (st.superview.size.width - 45)/2, h: 40, t: 80}
    st.corner_radius = 2
    st.text = "#{App::Persistence['choice_3']}"
  end

  def choice_four_button(st)
    st.background_color = rmq.color('#3BDBF0')
    st.color = color.white
    st.font = font.system(22)
    st.frame         = {grid: "g9:l13"}#{fr: 15, w: (st.superview.size.width - 45)/2, h: 40, t: 80}
    st.corner_radius = 2
    st.text = "#{App::Persistence['choice_4']}"
  end

  def root_view(st)
    st.background_color = rmq.color('#0D191D')
  end
end
