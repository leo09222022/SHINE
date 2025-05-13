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
    font-family: 'Pretendard', sans-serif;
  ">
    <div style="
      background: #ffffff;
      padding: 24px;
      border-radius: 12px;
      text-align: center;
      max-width: 320px;
      width: 90%;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    ">
      <p style="
        margin-bottom: 24px;
        font-size: 16px;
        color: #1D1D1F;
        line-height: 1.5;
      ">
        카카오맵 앱이 필요합니다.<br>설치하시겠습니까?
      </p>
      <div style="display: flex; justify-content: center; gap: 12px;">
        <button onclick="document.getElementById('kakaoPopup').remove()" style="
          padding: 8px 16px;
          border: none;
          border-radius: 4px;
          background-color: #CECECE;
          color: #1D1D1F;
          font-size: 14px;
          cursor: pointer;
        ">
          취소
        </button>
        <button onclick="redirectToKakaoInstallPage()" style="
          padding: 8px 16px;
          border: none;
          border-radius: 4px;
          background-color: #4285F4;
          color: white;
          font-size: 14px;
          cursor: pointer;
        ">
          설치
        </button>
      </div>
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
