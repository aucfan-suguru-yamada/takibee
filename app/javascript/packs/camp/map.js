$(document).on('turbolinks:load',function(){
var mayMap;
var service;

// マップの初期設定
function initialize() {
    // Mapクラスのインスタンスを作成（緯度経度は池袋駅に設定）
    var initPos = new google.maps.LatLng(35.729756, 139.711069);
    // 地図のプロパティを設定（倍率、マーカー表示位置、地図の種類）
    var myOptions = {
        zoom: 15,
        center: initPos,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    // #map_canvas要素にMapクラスの新しいインスタンスを作成
    myMap = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    // 検索の条件を指定（緯度経度、半径、検索の分類）
    var request = {
        location: initPos,
        radius: 1000,      // ※１ 表示する半径領域を設定(1 = 1M)
        types: ['cafe']    // ※２ typesプロパティの施設タイプを設定
    };
    var service = new google.maps.places.PlacesService(myMap);
    service.search(request, Result_Places);
}

// 検索結果を受け取る
function Result_Places(results, status){
    // Placesが検索に成功したかどうかをチェック
    if(status == google.maps.places.PlacesServiceStatus.OK) {
        for (var i = 0; i < results.length; i++) {
            // 検索結果の数だけ反復処理を変数placeに格納
            var place = results[i];
            createMarker({
                text : place.name,
                position : place.geometry.location
            });
        }
    }
}

// 入力キーワードと表示範囲を設定
//function SearchGo() {
//}


//検索の実行(SearchGo())
$(document).on('click', '#search_btn', function(){
    var initPos = new google.maps.LatLng(0,0);
    var mapOptions = {
        center : initPos,
        zoom: 0,
        mapTypeId : google.maps.MapTypeId.ROADMAP
    };
    // #map_canva要素にMapクラスの新しいインスタンスを作成
    myMap = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
    service = new google.maps.places.PlacesService(myMap);
    // input要素に入力されたキーワードを検索の条件に設定
    var myword = document.getElementById("search");
    var request = {
        query : myword.value,
        radius : 5000,
        location : myMap.getCenter()
    };
    service.textSearch(request, result_search);
});


//tableの削除ボタン
//$(document).on('click', '#delete_btn', function(){
//    var table = document.getElementById("table");
  //var tbody = document.getElementsByTagName("tbody");
//    console.log("tableの削除");
  //tableの削除
  //table.removeChild(tbody)
//    while (table.firstChild) {
//    table.removeChild(table.firstChild);
//  };
//});


//tableの作成
var rows=[];
var table = document.createElement("table");
//行の追加
rows.push(table.insertRow(-1));
var cell_head_name=rows[0].insertCell(-1);
cell_head_name.appendChild(document.createTextNode("Name"));
var cell_head_address=rows[0].insertCell(-1);
cell_head_address.appendChild(document.createTextNode("address"));
var cell_head_btn=rows[0].insertCell(-1);
cell_head_btn.appendChild(document.createTextNode("btn"));
//camp_idの受け取り
var camp_id = $('#camp_id').data("camp-id");

// 検索の結果を受け取る
function result_search(results, status) {
    var bounds = new google.maps.LatLngBounds();
    for(var i = 0; i < results.length; i++){
        createMarker({
            position : results[i].geometry.location,
            text : results[i].name,
            map : myMap
        });
        bounds.extend(results[i].geometry.location);

        //tableに行を追加
        rows.push(table.insertRow(-1));  // 行の追加
        if (table.rows[i+1].cells[0]) {
            console.log(table.rows[i+1].cells[0])
            var cell_name= table.rows[i+1].cells[0];
            var cell_address= table.rows[i+1].cells[1];
            var cell_button= table.rows[i+1].cells[2];
            cell_name.innerHTML = results[i].name;
            cell_address.innerHTML = results[i].formatted_address;
            cell_button.innerHTML = `<form action="/camps/${camp_id}/areas" method="post">
                                    <input type="hidden" name="name" value="${results[i].name}" id="area_name">
                                    <input type="hidden" name="address" value="${results[i].formatted_address}" id="area_address">
                                    <input type="submit" name="commit" value="追加" class="btn btn-primary" data-disable-with="追加">
                                    </form>`;
        } else {
        var cell_name=rows[i+1].insertCell(0);
        var cell_address=rows[i+1].insertCell(1);
        var cell_button=rows[i+1].insertCell(2);
        cell_name.innerHTML = results[i].name;
        cell_address.innerHTML = results[i].formatted_address;
        cell_button.innerHTML = `<form action="/camps/${camp_id}/areas" method="post">
                                <input type="hidden" name="name" value="${results[i].name}" id="area_name">
                                <input type="hidden" name="address" value="${results[i].formatted_address}" id="area_address">
                                <input type="submit" name="commit" value="追加" class="btn btn-primary" data-disable-with="追加">
                                </form>`;
        };
    };
    myMap.fitBounds(bounds);
    //tableにデータを追加
    document.getElementById("table").appendChild(table);
};

// 該当する位置にマーカーを表示
function createMarker(options) {
    // マップ情報を保持しているmyMapオブジェクトを指定
    options.map = myMap;
    // Markcrクラスのオブジェクトmarkerを作成
    var marker = new google.maps.Marker(options);
    // 各施設の吹き出し(情報ウインドウ)に表示させる処理
    var infoWnd = new google.maps.InfoWindow();
    infoWnd.setContent(options.text);
    // addListenerメソッドを使ってイベントリスナーを登録
    google.maps.event.addListener(marker, 'click', function(){
        infoWnd.open(myMap, marker);
    });
    return marker;
};

// ページ読み込み完了後、Googleマップを表示
google.maps.event.addDomListener(window, 'load', initialize);
//initialize();
});