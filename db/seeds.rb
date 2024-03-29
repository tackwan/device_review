# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!(
  [
    {email: 'taku@example.com', name: '拓', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
    {email: 'fuku@example.com', name: 'fuku', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")},
    {email: 'poy@example.com', name: 'poyfull', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")}
  ]
)

Category.create!(
  [
    {name: 'マウス'},
    {name: 'キーボード'},
    {name: 'ヘッドセット'},
    {name: 'モニター'},
    {name: 'マウスパッド'}
  ]
)

Review.create!(
  [
    {name: 'G-pro superlight', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-review1.jpg"), filename:"sample-review1.jpg"), maker: 'logicool', detail: '扱いやすくて、最高です', star: '4', category_id: '1', user_id: users[0].id },
    {name: 'apex pro TKL', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-review2.jpg"), filename:"sample-review2.jpg"), maker: 'SteelSeries', detail: 'タイピングの感覚がとても気持ち良い', star: '5', category_id: '2', user_id: users[1].id },
    {name: 'Kraken', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-review3.jpg"), filename:"sample-review3.jpg"), maker: 'Razer', detail: '音がよく聞こえて、マイクの音質もよいです', star: '3', category_id: '3', user_id: users[2].id },
    {name: 'starlight-12', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-review4.jpg"), filename:"sample-review4.jpg"), maker: 'finalmouse', detail: 'とても軽くて、充電持ちも最高', star: '4', category_id: '1', user_id: users[1].id },
    {name: 'XL2566K ゲーミングモニター', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-review5.jpg"), filename:"sample-review5.jpg"), maker: 'BenQ', detail: '360Hzの最高峰のモニターです', star: '5', category_id: '4', user_id: users[0].id },
    {name: 'viper mini signature edition', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-review6.jpg"), filename:"sample-review6.jpg"), maker: 'Razer', detail: 'とてもかっこよくて良い。値段がネック', star: '4', category_id: '1', user_id: users[0].id }
  ]
)

Comment.create!(
  [
    {comment: '参考になりました', review_id: '1', user_id: users[1].id},
    {comment: '分かりやすい！', review_id: '2', user_id: users[2].id}
  ]
)


Admin.create!(
  [
    {email: 'admin@admin.com', password: 'admin1'}
  ]
)