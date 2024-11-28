# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Cleaning up database..."
Comment.delete_all
Message.delete_all
User.delete_all

puts "Creating users..."
# 添加默认用户
User.find_or_create_by(name: '李华')
User.find_or_create_by(name: '漫漫🐟')

puts "Creating messages and comments..."
messages = [
  {
    id: '19',
    author_name: '漫漫🐟',
    content: '16快乐   小鑫子   快快长大[em]e113[/em][em]e113[/em][em]e113[/em]',
    created_at: '2016-01-01 00:47:06',
    comments: [
      {
        id: '19-1',
        author_name: '李华',
        content: '[em]e400826[/em][em]e400825[/em][em]e400822[/em][em]e400832[/em][em]e401181[/em][em]e400831[/em][em]e400850[/em][em]e400851[/em][em]e400849[/em][em]e400823[/em][em]e400827[/em][em]e400828[/em][em]e400833[/em][em]e400836[/em][em]e400866[/em][em]e400829[/em]',
        created_at: '2015-12-31 23:48:33'
      }
    ]
  },
  {
    id: '20',
    author_name: '漫漫🐟',
    content: '圣诞快乐[em]e400188[/em][em]e400188[/em][em]e400188[/em]',
    created_at: '2015-12-25 09:27:42',
    comments: [
      {
        id: '20-1',
        author_name: '李华',
        content: '快乐，么么哒',
        created_at: '2015-12-25 09:29:05'
      }
    ]
  },
  {
    id: '21',
    author_name: '漫漫🐟',
    content: '平安夜快乐[em]e129[/em][em]e129[/em][em]e129[/em]',
    created_at: '2015-12-24 19:52:34',
    comments: []
  }
]
# 提取上面的信息，还是用messages的格式，只提取uin为1169545801的用户的信息，content字段来源是ubbContent，结果放在new_messages




messages.each do |message_data|
  user = User.find_by(name: message_data[:author_name])
  message = Message.create!(
    id: message_data[:id].to_i,
    user_id: user.id,
    content: message_data[:content],
    created_at: message_data[:created_at]
  )

  message_data[:comments].each do |comment_data|
    comment_user = User.find_by(name: comment_data[:author_name])
    Comment.create!(
      id: comment_data[:id].gsub('-', '').to_i,
      message: message,
      user_id: comment_user.id,
      content: comment_data[:content],
      created_at: comment_data[:created_at]
    )
  end
end

puts "Seeding completed!"
