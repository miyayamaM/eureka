# frozen_string_literal: true

User.create!(name: 'First User',
             email: 'first@example.com',
             password: 'password',
             password_confirmation: 'password',
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name = "#{Faker::Name.name}#{n}"
  email = "example#{n + 1}@example.com"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

categories = %w[遺伝学 医学 化学 環境学 経済学 古生物学 昆虫学 細胞学 植物学 水産学 天文学 動物学 文学]

categories.each { |category| Category.create(name: category) }

user = User.find(1)
50.times do
  title = "#{Faker::Coffee.regions}に生息する#{Faker::Creature::Animal.name}の#{Faker::Lorem.word}"
  user.articles.create!(title: title, content: 'test', citation: 'Book')
end

users = User.all[2..50]
users.each do |user|
  12.times do |n|
    title = "#{Faker::Coffee.regions}に生息する#{Faker::Creature::Animal.name}の#{Faker::Lorem.word}"
    user.articles.create!(title: title, content: 'test', citation: 'Book', category_id: n + 1)
  end
end

users.each_with_index do |user, i|
  articles = Article.where(id: 1..i + 1)
  articles.each { |article| user.bookmark(article) }
end

user = User.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

Article.create(title: '生物は遺伝子が全てを決めている？', citation: 'リチャード・ドーキンス「利己的な遺伝子」', content: '遺伝子が決める', category_id: 1, user_id: 1)
Article.create(title: '分子生物学の基礎', citation: '東京大学出版「分子生物学」', content: '遺伝子とは？', category_id: 1, user_id: 2)
Article.create(title: 'エピジェネティクスの世界', citation: 'XX出版「最新の分子生物学」', content: 'ヒストンのメチル化', category_id: 1, user_id: 3)
Article.create(title: '遺伝子の二重螺旋構造', citation: 'Nature volume 171, pages737–738(1953)', content: 'Watsonとcrickらが発見した', category_id: 1, user_id: 4)
Article.create(title: '遺伝子とタンパク質の1対1対応', citation: 'PNAS, G. W. Beadle and E. L. Tatum, 「Genetic Control of Biochemical Reactions in Neurospora」(1941)', content: '一遺伝子一酵素説の説明', category_id: 1, user_id: 5)
Article.create(title: 'ゲノム編集は人間を救うか？', citation: 'XXX', content: '倫理的問題もある', category_id: 1, user_id: 6)

Article.create(title: '新型コロナウイルスのワクチンに対するレムデシビルの効果', citation: 'NEJM,「Compassionate Use of Remdesivir for Patients with Severe Covid-19」', content: '患者レポート', category_id: 2, user_id: 1)
Article.create(title: '好きなBGMは風邪を予防する', citation: "'Effect of Music and Auditory Stimuli on Secretory Immunoglobulin a (IGA)', Carl J. Charnetski, Francis X. Brennan, Jr., James F. Harrison James F. Harrison, 1998", content: 'good is good for you', category_id: 2, user_id: 2)
Article.create(title: 'iPS細胞の医学における貢献', citation: 'XX出版「xxx」', content: '山中伸哉先生が受賞', category_id: 2, user_id: 3)
Article.create(title: 'PD-1抗体の発見はなぜノーベル賞を受賞したのか', citation: 'The 2018 Nobel Prize in Physiology or Medicine', content: '日本人の受賞', category_id: 2, user_id: 4)
Article.create(title: 'ストレスは遺伝子に変化をもたらし、うつ病を引き起こす', citation: 'Nature Medicine', content: 'エピジェネティクス的発見', category_id: 2, user_id: 5)
Article.create(title: "'痛くて寝れない'の生理学的メカニズム", citation: 'Nature', content: '精神的なものだけではなかった', category_id: 2, user_id: 6)

Article.create(title: 'スピノサウルスは水中移動に適した尻尾を持つ', citation: 'Nature (2020)', content: 'すごい恐竜', category_id: 6, user_id: 2)
Article.create(title: 'ベーリンジアにおけるマンモスの絶滅パターン', citation: 'Nature Communications volume 3, Article number: 893 (2012)', content: '時空間的パターンを調べた', category_id: 6, user_id: 3)
Article.create(title: 'ラクダの祖先は北極で生まれた', citation: 'Nature Communications volume 4, Article number: 1550 (2013)', content: '化石を調べた', category_id: 6, user_id: 4)
Article.create(title: '化石から太古の寄生ハチが見つかった', citation: 'Nature Communications volume 9, Article number: 3325 (2018)', content: '昆虫', category_id: 6, user_id: 5)
Article.create(title: '世界最古のヘビの化石', citation: 'Nature Communications volume 6, Article number: 5996 (2015)', content: '7000万年前であると推定', category_id: 6, user_id: 6)
Article.create(title: '生き残っていた古代のサメcladodontomorph', citation: 'Nature Communications volume 4, Article number: 2669 (2013)', content: '絶滅したと考えられていた', category_id: 6, user_id: 7)

Article.create(title: 'オットセイは陸と海で違う寝方をする', citation: 'Lyamin et al., 2018, Current Biology 28', content: '脳波を測定', category_id: 12, user_id: 1)
Article.create(title: 'ウミガメはビニールゴミを見分ける', citation: 'Scientific report (2016)', content: 'カメラをつけて解析', category_id: 12, user_id: 2)
Article.create(title: '浮気をするオオミズナギドリ', citation: "Miho Sakao, Hirohiko Takeshima, Koji Inoue, Katsufumi Sato, 'Extra-pair paternity in socially monogamous Streaked Shearwater; forced copulation or female solicitation?' Journal of Ornithology Online edition: 2018年7月30日, doi:10.1007/s10336-018-1587-3.", content: '一夫一妻性の海鳥', category_id: 12, user_id: 3)
Article.create(title: '早起きは三文の得な鳥', citation: "Lesku JA1, Rattenborg NC, Valcu M, Vyssotski AL, Kuhn S, Kuemmeth F, Heidrich W, Kempenaers B., 'Adaptive sleep loss in polygynous pectoral sandpipers.', Science (2012)", content: '昆虫', category_id: 12, user_id: 5)
Article.create(title: 'ハイイロガンの刷り込み', citation: 'コンラート・ローレンツ「ソロモンの指輪」', content: '動物の行動観察から、何を考えているかわかる', category_id: 12, user_id: 6)
Article.create(title: 'ミツバチのダンスによるコミュニケーション', citation: 'XX出版「生態学」', content: '8の字ダンスで餌の場所を教える', category_id: 12, user_id: 7)
