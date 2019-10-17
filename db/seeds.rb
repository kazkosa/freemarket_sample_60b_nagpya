mens = Category.create(:name=>"メンズ")

mens_tops = mens.children.create(:name=>"トップス")

mens_tops.children.create([{:name=>"すべて"}, {:name=>"Tシャツ/カットソー（半袖/袖なし）"},{:name=>"Tシャツ/カットソー（七分/長袖）"}])

