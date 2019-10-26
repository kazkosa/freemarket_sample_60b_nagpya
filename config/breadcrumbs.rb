crumb :root do
  link "メルカリ", root_path
end

crumb :mypage do
  link "マイページ", users_path
  parent :root
end

crumb :card do
  link "支払い方法", card_index_path
  parent :mypage
end

crumb :logout do
  link "ログアウト", logout_user_path
  parent :mypage
end

crumb :identification do
  link "本人情報の登録", identification_user_path
  parent :mypage
end

crumb :plofile do
  link "プロフィール", plofile_user_path
  parent :mypage
end