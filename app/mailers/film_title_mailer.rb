class FilmTitleMailer < ApplicationMailer
  def analysis
    @greeting = "Hi"

    mail to: "rjr.arroyo@gmail.com", subject: 'Hi'
  end
end
