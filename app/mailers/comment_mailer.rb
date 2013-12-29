class CommentMailer < ActionMailer::Base
  helper :application

  def new_comment(user, comment)
    @user, @comment, @link = user, comment, comment.commentable

    headers("Message-ID" => "link-#{@link.id}@feedforward.io", "In-Reply-To" => "link-#{@link.id}@feedforward.io")

    mail(
      from: "#{user.full_name} <#{user.email}>",
      to: User.receiving_emails.pluck(:email),
      subject: "[FeedForward.io] #{@user.full_name} commented on #{@link.title}"
    )
  end
end
