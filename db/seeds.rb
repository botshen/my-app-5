# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'securerandom'

puts "Cleaning up database..."
Comment.delete_all
Message.delete_all
User.delete_all

puts "Creating users..."
# 只创建两个用户
User.find_or_create_by(name: '李华')
User.find_or_create_by(name: '漫漫🐟')

puts "Creating messages and comments..."
messages = [

  {
    id: '23',
    author_name: '漫漫🐟',
    content: '中秋快乐',
    created_at: '2013-09-19 12:22:42',
    comments: []
  },
  {
    id: '22',
    author_name: '漫漫🐟',
    content: '帮你踩踩.还有,踩扁你',
    created_at: '2013-07-18 16:01:41',
    comments: []
  },
  {
    id: '20',
    author_name: '漫漫🐟',
    content: '踩踩,我够意思吧',
    created_at: '2013-03-22 10:04:59',
    comments: [
      {
        id: '20-1',
        author_name: '李华',
        content: "够\n[em]e4005[/em]\n",
        created_at: '2013-03-22 10:13:21'
      },
      {
        id: '20-2',
        author_name: '漫漫🐟',
        content: '嘿嘿',
        created_at: '2013-03-22 10:15:54'
      },
      {
        id: '20-3',
        author_name: '李华',
        content: '哈哈哈啊[em]e4018[/em] ',
        created_at: '2013-03-22 10:16:54'
      },
      {
        id: '20-4',
        author_name: '漫漫🐟',
        content: '傻样',
        created_at: '2013-03-22 11:50:17'
      }
    ]
  },
  {
    id: '19',
    author_name: '漫漫🐟',
    content: '              好好活着吧',
    created_at: '2013-02-06 14:11:10',
    comments: []
  },
  {
    id: '1000050008',
    author_name: '漫漫🐟',
    content: '简简单单  希望你一直这样    那么单纯',
    created_at: '2015-10-26 12:38:17',
    comments: []
  },
  {
    id: '1000050007',
    author_name: '漫漫🐟',
    content: '曾经有一件棘手的事情放在我面前，我没有珍惜，等我失去的时候我才后悔莫及，人世间最痛苦的事莫过于此。如果上天能够给我一个再来一次的机会，我会对那个你说出三个字："还钱啦"。如果非要在这笔账上加上一个期限，我希望是……一天内还清！',
    created_at: '2015-10-15 20:14:32',
    comments: [
      {
        id: '1000050007-1',
        author_name: '李华',
        content: '[em]e328531[/em]',
        created_at: '2015-10-15 20:19:57'
      }
    ]
  },
  {
    id: '1000050006',
    author_name: '漫漫🐟',
    content: '哈哈  中秋快乐[em]e113[/em][em]e113[/em][em]e113[/em]',
    created_at: '2015-09-27 08:08:42',
    comments: [
      {
        id: '1000050006-1',
        author_name: '李华',
        content: '[em]e328513[/em][em]e328513[/em][em]e328513[/em]你也是',
        created_at: '2015-09-27 08:15:43'
      }
    ]
  },
  {
    id: '1000050005',
    author_name: '漫漫🐟',
    content: '小鑫子   好好学习吧',
    created_at: '2014-09-08 20:12:17',
    comments: []
  },
  {
    id: '1000050004',
    author_name: '漫漫🐟',
    content: '这里还有我去年给你发的 中秋快乐呢',
    created_at: '2014-09-08 20:11:36',
    comments: []
  },
  {
    id: '1000050003',
    author_name: '漫漫🐟',
    content: '月饼节快乐哈  ',
    created_at: '2014-09-08 20:09:55',
    comments: []
  },
  {
    id: '1000050013',
    author_name: '漫漫🐟',
    content: '16快乐   小鑫子   快快长大[em]e113[/em][em]e113[/em][em]e113[/em]',
    created_at: '2016-01-01 00:47:06',
    comments: [
      {
        id: '1000050013-1',
        author_name: '李华',
        content: '[em]e400826[/em][em]e400825[/em][em]e400822[/em][em]e400832[/em][em]e401181[/em][em]e400831[/em][em]e400850[/em][em]e400851[/em][em]e400849[/em][em]e400823[/em][em]e400827[/em][em]e400828[/em][em]e400833[/em][em]e400836[/em][em]e400866[/em][em]e400829[/em]',
        created_at: '2015-12-31 23:48:33'
      }
    ]
  },
  {
    id: '1000050012',
    author_name: '漫漫🐟',
    content: '圣诞快乐[em]e400188[/em][em]e400188[/em][em]e400188[/em]',
    created_at: '2015-12-25 09:27:42',
    comments: [
      {
        id: '1000050012-1',
        author_name: '李华',
        content: '快乐，么么哒',
        created_at: '2015-12-25 09:29:05'
      }
    ]
  },
  {
    id: '1000050011',
    author_name: '漫漫🐟',
    content: '平安夜快乐[em]e129[/em][em]e129[/em][em]e129[/em]',
    created_at: '2015-12-24 19:52:34',
    comments: []
  },
  {
    id: '1000050184',
    author_name: '李华',
    content: '生日快乐呀[em]e400198[/em]',
    created_at: '2024-06-18 07:22:06',
    comments: []
  },
  {
    id: '1000050183',
    author_name: '李华',
    content: '[em]e194[/em][em]e197[/em][em]e195[/em]',
    created_at: '2023-11-14 16:06:14',
    comments: []
  },
  {
    id: '1000050182',
    author_name: '李华',
    content: '生日快乐',
    created_at: '2023-06-30 08:54:03',
    comments: []
  },
  {
    id: '1000050181',
    author_name: '李华',
    content: '生日快乐[em]e400083[/em]',
    created_at: '2022-06-11 01:51:47',
    comments: []
  },
  {
    id: '1000050180',
    author_name: '李华',
    content: '2022新年快乐，希望不会忘记我，祝你开开心心每一天！',
    created_at: '2022-02-01 00:11:42',
    comments: []
  },
  {
    id: '1000050179',
    author_name: '李华',
    content: '踩踩',
    created_at: '2022-01-05 21:13:31',
    comments: []
  },
  {
    id: '1000050177',
    author_name: '李华',
    content: '[em]e400186[/em][em]e400186[/em][em]e400186[/em]',
    created_at: '2021-06-22 08:08:10',
    comments: [
      {
        id: '1000050177-1',
        author_name: '漫漫🐟',
        content: '谢谢',
        created_at: '2021-06-22 08:45:43'
      }
    ]
  },
  {
    id: '1000050172',
    author_name: '李华',
    content: '[em]e173[/em]',
    created_at: '2019-03-12 07:07:15',
    comments: []
  },
  {
    id: '1000050171',
    author_name: '李华',
    content: '[em]e213[/em]生日快乐[em]e400562[/em][em]e213[/em]',
    created_at: '2018-06-26 06:58:16',
    comments: [
      {
        id: '1000050171-1',
        author_name: '漫漫🐟',
        content: '谢谢你👻',
        created_at: '2018-06-26 07:37:51'
      }
    ]
  },
  {
    id: '1000050105',
    author_name: '李华',
    content: '小年。。。。踩一脚[em]e104[/em]',
    created_at: '2016-02-01 22:50:30',
    comments: [
      {
        id: '1000050105-1',
        author_name: '漫漫🐟',
        content: '[em]e192[/em][em]e192[/em][em]e192[/em][em]e195[/em][em]e195[/em][em]e195[/em][em]e192[/em][em]e192[/em][em]e192[/em][em]e195[/em][em]e195[/em][em]e195[/em]',
        created_at: '2016-02-02 00:11:26'
      }
    ]
  },
  {
    id: '1000050094',
    author_name: '李华',
    content: '老给我留言，我也回一个吧，16快乐，期末全过。\n天天开心[em]e400829[/em][em]e400829[/em][em]e400829[/em]',
    created_at: '2016-01-01 00:51:01',
    comments: [
      {
        id: '1000050094-1',
        author_name: '漫漫🐟',
        content: '对   期末过过过',
        created_at: '2016-01-01 00:57:00'
      }
    ]
  },
  {
    id: '1000050073',
    author_name: '李华',
    content: '好久没来了，话说你留言板一半的楼都是我盖的[em]e128[/em]想你了来踩踩[em]e144[/em]～一切都好吧[em]e198[/em]',
    created_at: '2015-11-20 18:30:09',
    comments: [
      {
        id: '1000050073-1',
        author_name: '漫漫🐟',
        content: '话说你还记得我吗   [em]e141[/em][em]e141[/em][em]e141[/em]  我不好   一点都不好  仿佛高四的生活',
        created_at: '2015-11-20 20:36:16'
      }
    ]
  },
  {
    id: '1000050024',
    author_name: '李华',
    content: '2015年就要到了。曾经拥有的不要忘记，属于自己的不要放弃，辛劳得来的更要珍惜，已经失去的当作回忆，跨年快乐，愿你在2015年一切都能顺顺利利，高考一起加油！',
    created_at: '2014-12-31 23:01:38',
    comments: [
      {
        id: '1000050024-1',
        author_name: '漫漫🐟',
        content: '2015,将会是崭新的开始的,一起为高考努力吧.',
        created_at: '2015-01-01 01:06:17'
      }
    ]
  },
  {
    id: '234244',
    author_name: '李华',
    content: '嘿嘿',
    created_at: '2013-03-23 19:19:42',
    comments: []
  },
  {
    id: '3432421',
    author_name: '李华',
    content: '呵呵',
    created_at: '2013-03-23 18:09:07',
    comments: [
      {
        id: '31423441',
        author_name: '漫漫🐟',
        content: '敢不留呵呵吗',
        created_at: '2013-03-23 18:17:00'
      }
    ]
  },
  {
    id: '432424',
    author_name: '李华',
    content: '\n oooO ↘┏━┓ ↙ Oooo \n ( 踩)→┃你┃ ←(死 ) \n  \\ ( →┃√┃ ← ) / \n　 \\_)↗┗━┛ ↖(_/',
    created_at: '2013-03-22 21:19:42',
    comments: []
  }
]



messages.each do |message_data|
  user = User.find_by(name: message_data[:author_name])
  message = Message.create!(
    id: SecureRandom.random_number(1..1000000),
    user_id: user.id,
    content: message_data[:content],
    created_at: message_data[:created_at]
  )

  message_data[:comments].each do |comment_data|
    comment_user = User.find_by(name: comment_data[:author_name])
    Comment.create!(
      id: SecureRandom.random_number(1..1000000),
      message: message,
      user_id: comment_user.id,
      content: comment_data[:content],
      created_at: comment_data[:created_at]
    )
  end
end

puts "Seeding completed!"
