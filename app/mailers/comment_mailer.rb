class CommentMailer < ActionMailer::Base
  helper :application

  def new_comment(user, comment)
    @user, @comment, @link = user, comment, comment.commentable

    mail(
      from: "#{user.full_name} <#{user.email}>",
      to: User.pluck(:email),
      subject: "[FeedForward.io] #{@user.full_name} commented on #{@link.title}"
    )
  end
end
