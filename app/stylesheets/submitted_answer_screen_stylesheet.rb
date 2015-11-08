class SubmittedAnswerScreenStylesheet < ApplicationStylesheet
  # Add your view stylesheets here. You can then override styles if needed,
  # example: include FooStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def submitted_label(st)
    #st.frame = {l: 40, t: rmq(:username_input).frame.bottom + 8, w: 120, h: 120}
    st.frame = {grid: "a3:l4"}
    #st.font = font.medium
    st.font = UIFont.fontWithName('Avenir Next', size: 22.0)
    st.text = "Answer Submitted!"
    st.text_alignment = :center
    st.color = rmq.color('#3BDBF0')
    st.view.lineBreakMode = NSLineBreakByWordWrapping
  end

  def root_view(st)
    st.background_color = rmq.color('#0D191D')
  end
end
