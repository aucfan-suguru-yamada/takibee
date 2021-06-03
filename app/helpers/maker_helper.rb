module MakerHelper

  def translate_maker_name(name)
    maker_hash = {'ビーズ': 'DOD',
                  'コールマンジャパン': 'Coleman（コールマン）',
                  '新越ワークス': 'UNIFLAME（ユニフレーム)',
                  'スノーピーク': 'snow peak（スノーピーク）',
                  'パール金属': 'CAPTAIN STAG（キャプテンスタッグ）',
                  'キャプテンスタッグ': 'CAPTAIN STAG（キャプテンスタッグ）',
                  'ロゴスコーポレーション': 'LOGOS（ロゴス）',
                  'カンセキ': 'tent-Mark DESIGNS（テンマクデザイン）',
                  'キャンパルジャパン': 'OGAWA（オガワ）',
                  'エイアンドエフ': 'HILLBERG（ヒルバーグ）',
                  '岩谷産業': 'Iwatani（イワタニ）',
                  '新富士バーナー': 'SOTO（ソト）',
                  '山渓': 'NANGA（ナンガ）',
                  'ナンガ': 'NANGA（ナンガ）',
                  'イスカ': 'ISUKA（イスカ）',
                  'ゴールドウイン': 'THE NORTH FACE（ノースフェイス）',
                  'モチヅキ': 'MSR',
                  'モンベル': 'mont-bell（モンベル）',
                  'ナニワ': 'North Eagle（ノースイーグル）',
                  'カワセ': 'BUNDOK（バンドック）',
                  'ファロスインターナショナル': 'Tentipi（テンティピ）',
                  'ランドウェル': 'CHUMS（チャムス）',
                  'ベルモント': 'Belmont(ベルモント）'
                }

    maker_hash[name.to_sym].present? ? maker_hash[name.to_sym] : name
  end

  def product_name(name)
    product_name_array = ['DOD','コールマン','Coleman','uniflame','ユニフレーム','UNIFLAME','スノーピーク','snow peak',
                          'パール金属', 'CAPTAIN STAG','キャプテンスタッグ','ロゴスコーポレーション','LOGOS',
                          'ロゴス','カンセキ','テンマクデザイン','tent-Mark DESIGNS','キャンパルジャパン',
                          'OGAWA','オガワ','エイアンドエフ','HILLBERG','ヒルバーグ','岩谷産業','Iwatani','イワタニ',
                          '新富士バーナー','SOTO','山渓','NANGA','ISUKA','イスカ','ゴールドウイン','THE NORTH FACE',
                          'ノースフェイス','MSR','モンベル','mont-bell','ナニワ','North Eagle','ノースイーグル',
                          'カワセ','BUNDOK','バンドック','ファロスインターナショナル','Tentipi','テンティピ','ランドウェル',
                          'CHUMS（チャムス）','チャムス','山善','ベルモント','Belmont'
                          ]
    for i in 0..product_name_array.count-1
      if name.include?(product_name_array[i])
        name = name.gsub(/#{product_name_array[i]}/,'')
      else
        name
      end
    end
    name
  end
end
