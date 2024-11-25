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
    id: '2',
    author_name: '漫漫🐟',
    content: '16快乐 小鑫子 快快长大',
    created_at: '2016-01-01 00:47:06',
    comments: [
      {
        id: '2-1',
        author_name: '李华',
        content: '谢谢！新年快乐！',
        created_at: '2016-01-01 00:48:33'
      }
    ]
  },
  {
    id: '3',
    author_name: '漫漫🐟',
    content: '圣诞快乐',
    created_at: '2015-12-25 09:27:42',
    comments: [
      {
        id: '3-1',
        author_name: '李华',
        content: '快乐，么么哒',
        created_at: '2015-12-25 09:29:05'
      }
    ]
  },
  {
    id: '4',
    author_name: '漫漫🐟',
    content: '简简单单 希望你一直这样 那么单纯',
    created_at: '2015-10-26 12:38:17',
    comments: []
  },
  {
    id: '5',
    author_name: '漫漫🐟',
    content: '平安夜快乐',
    created_at: '2015-12-24 19:52:34',
    comments: []
  },
  {
    id: '6',
    author_name: '漫漫🐟',
    content: '曾经有一件棘手的事情放在我面前，我没有珍惜，等我失去的时候我才后莫及，人世间最痛苦的事莫过于此。如果上天能够给我一个再来一次的机会，我会对那个你说出三个字："还钱啦"。如果非要在这笔账上加上一个期限，我希望是……一天内还清！',
    created_at: '2015-10-15 20:14:32',
    comments: [
      {
        id: '6-1',
        author_name: '李华',
        content: '😓',
        created_at: '2015-10-15 20:19:57'
      }
    ]
  },
  {
    id: '7',
    author_name: '漫漫🐟',
    content: '哈哈 中秋快乐😬😬😬',
    created_at: '2015-09-27 08:08:42',
    comments: [
      {
        id: '7-1',
        author_name: '李华',
        content: '你也是😬😬😬',
        created_at: '2015-09-27 08:09:03'
      }
    ]
  },
  {
    id: '8',
    author_name: '漫漫🐟',
    content: '小鑫子 好好学习吧',
    created_at: '2014-09-08 20:12:17',
    comments: []
  },
  {
    id: '9',
    author_name: '漫漫🐟',
    content: '这里还有我去年给你发的 中秋快乐呢',
    created_at: '2014-09-08 20:11:36',
    comments: []
  },
  {
    id: '10',
    author_name: '漫漫🐟',
    content: '月饼节快乐哈',
    created_at: '2014-09-08 20:09:55',
    comments: []
  },
  {
    id: '11',
    author_name: '漫漫🐟',
    content: '中秋快乐',
    created_at: '2013-09-19 12:22:59',
    comments: [
      {
        id: '11-1',
        author_name: '李华',
        content: '快乐',
        created_at: '2013-09-19 12:26:39'
      }
    ]
  },
  {
    id: '12',
    author_name: '漫漫🐟',
    content: '帮你踩踩.还有,踩扁你',
    created_at: '2013-07-18 16:01:41',
    comments: []
  },
  {
    id: '13',
    author_name: '漫漫🐟',
    content: '踩踩,我够意思吧',
    created_at: '2013-03-22 10:04:59',
    comments: [
      {
        id: '13-1',
        author_name: '李华',
        content: '够',
        created_at: '2013-03-22 10:06:41'
      },
      {
        id: '13-2',
        author_name: '漫漫🐟',
        content: '嘿嘿',
        created_at: '2013-03-22 10:09:14'
      },
      {
        id: '13-3',
        author_name: '李华',
        content: '哈哈哈啊',
        created_at: '2013-03-22 10:10:14'
      },
      {
        id: '13-4',
        author_name: '漫漫🐟',
        content: '傻样',
        created_at: '2013-03-22 11:43:37'
      }
    ]
  },
  {
    id: '14',
    author_name: '漫漫🐟',
    content: '好好活着吧',
    created_at: '2013-02-06 14:11:10',
    comments: []
  }
]

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
