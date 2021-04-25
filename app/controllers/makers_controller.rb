class MakersController < ApplicationController
  def index
    @makers = Maker.all
  end

  def new
    @maker = Maker.new
  end

  def create
    @maker = Maker.new(maker_params)
    if @maker.save
      redirect_to makers_path, flash: {success: 'メーカー名を登録しました'}
    else
      flash.now[:danger] = 'メーカー名の登録に失敗しました'
      render :new
    end
  end

  def update
  end

  def destroy
  end

  def api
    # hash形式でパラメタ文字列を指定し、URL形式にエンコード
    # params = URI.encode_www_form({zipcode: '7830060'})
    # URIを解析し、hostやportをバラバラに取得できるようにする
    #uri = URI.parse("https://app.rakuten.co.jp/services/api/IchibaTag/Search/20140222?format=json&tagId=1001908&formatVersion=2&applicationId=1013263204875235587")
    # リクエストパラメタを、インスタンス変数に格納
    #@query = uri.query
    # 1.urlを解析する
    url = URI.parse("https://app.rakuten.co.jp/services/api/IchibaItem/Search/20170706?format=json&keyword=%E5%8D%83%E5%88%A9%E4%BC%91&applicationId=1013263204875235587")
    # 2.httpの通信を設定する
    # 通信先のホストやポートを設定
    https = Net::HTTP.new(url.host, url.port)
    # httpsで通信する場合、use_sslをtrueにする
    https.use_ssl = true
    # 3.リクエストを作成する
    req = Net::HTTP::Get.new(url.path)
    # 4.リクエストを投げる/レスポンスを受け取る
    res = https.request(req)
    # 5.データを変換する
    @result = JSON.parse(res.body)
  end



  private

  def maker_params
    params.require(:maker).permit(:name)
  end
end
