(function () {
  const popupHTML = `
    <div id="kakaoPopup" style="
      position: fixed;
      top: 0; left: 0;
      width: 100vw;
      height: 100vh;
      background-color: rgba(0, 0, 0, 0.5);
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 9999;
      font-family: sans-serif;
    ">
      <div style="
        background: white;
        padding: 20px;
        border-radius: 8px;
        text-align: center;
        max-width: 300px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.3);
      ">
        <p style="margin-bottom: 20px;">카카오맵 앱이 필요합니다.<br>설치하시겠습니까?</p>
        <button onclick="document.getElementById('kakaoPopup').remove()" style="margin-right:10px;">취소</button>
        <button onclick="redirectToKakaoInstallPage()">설치</button>
      </div>
    </div>
  `;

  window.openKakaoPopUp = function () {
    if (!document.getElementById("kakaoPopup")) {
      document.body.insertAdjacentHTML('beforeend', popupHTML);
    }
  };

  // OS 감지 및 스토어 이동
  window.redirectToKakaoInstallPage = function () {
    const ua = navigator.userAgent;

    const isIOS = /iPhone|iPad|iPod/i.test(ua);
    const isAndroid = /Android/i.test(ua);

    let storeUrl = "https://www.kakaocorp.com/service/KakaoMap"; // fallback

    if (isAndroid) {
      storeUrl = "https://play.google.com/store/apps/details?id=net.daum.android.map";
    } else if (isIOS) {
      storeUrl = "https://apps.apple.com/kr/app/id304608425";
    }

    window.open(storeUrl, "_blank");
  };
})();
