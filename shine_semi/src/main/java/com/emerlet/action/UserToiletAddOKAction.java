package com.emerlet.action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emerlet.dao.UserToiletDAO;
import com.emerlet.dao.ReviewDAO;
import com.emerlet.vo.UserToiletVO;
import com.emerlet.vo.ReviewVO;

public class UserToiletAddOKAction {

	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("UserToiletAddOKAction.execute() called");

		try {
			request.setCharacterEncoding("UTF-8");

			UserToiletVO userToilet = new UserToiletVO();
			userToilet.setUserName(request.getParameter("userName"));
			userToilet.setUserRoadAddress(request.getParameter("userRoadAddress"));

			String maleToilet = request.getParameter("userMaleToilet");
			String femaleToilet = request.getParameter("userFemaleToilet");
			String disabledToilet = request.getParameter("userDisabledToilet");
			String hasDiaperTable = request.getParameter("userHasDiaperTable");

			// "모름" 선택 시 null 설정, 그렇지 않으면 값 그대로 설정
			userToilet.setUserMaleToilet("U".equals(maleToilet) ? null : maleToilet);
			userToilet.setUserFemaleToilet("U".equals(femaleToilet) ? null : femaleToilet);
			userToilet.setUserDisabledToilet("U".equals(disabledToilet) ? null : disabledToilet);
			userToilet.setUserHasDiaperTable("U".equals(hasDiaperTable) ? null : hasDiaperTable);

			userToilet.setUserDescription(request.getParameter("userDescription"));

			System.out.println("FormData: name=" + userToilet.getUserName());
			System.out.println("FormData: address=" + userToilet.getUserRoadAddress());
			System.out.println("FormData: maleToilet=" + userToilet.getUserMaleToilet());
			System.out.println("FormData: femaleToilet=" + userToilet.getUserFemaleToilet());
			System.out.println("FormData: disabledToilet=" + userToilet.getUserDisabledToilet());
			System.out.println("FormData: hasDiaperTable=" + userToilet.getUserHasDiaperTable());

			try {
				String userLatStr = request.getParameter("userLat");
				String userLngStr = request.getParameter("userLng");

				System.out.println("Lat/Lng: " + userLatStr + ", " + userLngStr);

				if (userLatStr != null && !userLatStr.isEmpty() && userLngStr != null && !userLngStr.isEmpty()) {
					userToilet.setUserLat(Double.parseDouble(userLatStr));
					userToilet.setUserLng(Double.parseDouble(userLngStr));
				} else {
					request.setAttribute("errorMessage", "위도와 경도 정보가 없습니다. 지도에서 위치를 선택해주세요.");
					return "toiletAdd.jsp";
				}
			} catch (NumberFormatException e) {
				System.out.println("예외 발생: " + e.getMessage());
				return "toiletAdd.jsp";
			}

			// 파일 업로드 부분은 생략하고 photoUrl을 빈 문자열로 설정
			userToilet.setPhotoUrl("");

			UserToiletDAO userToiletDAO = new UserToiletDAO();
			int toiletId = userToiletDAO.addUserToilet(userToilet); // 수정된 메서드 (ID 반환)

			System.out.println("toiletId: " + toiletId);

			if (toiletId > 0) {
				ReviewVO review = new ReviewVO();

				review.setCleanliness(Integer.parseInt(request.getParameter("cleanliness")));
				review.setSafety(Integer.parseInt(request.getParameter("safety")));
				review.setAccessibility(-1); 
				review.setSupplies(null);  // supplies가 없으면 null 또는 빈 문자열
				review.setUserToiletId(toiletId);
				review.setCreatedAt(new java.util.Date());

				ReviewDAO reviewDAO = new ReviewDAO();
				int result = reviewDAO.insertReview(review);
				boolean reviewResult = result > 0;

				System.out.println("리뷰 저장 결과: " + reviewResult);

				request.setAttribute("message", "화장실 등록이 성공적으로 요청되었습니다. 관리자 검토 후 지도에 표시됩니다.");
				return "toiletAddOK.jsp";
			} else {
				request.setAttribute("errorMessage", "화장실 등록 중 오류가 발생했습니다. 다시 시도해주세요.");
				return "toiletAdd.jsp";
			}
		} catch (Exception e) {
			System.out.println("예외 발생: " + e.getMessage());
			e.printStackTrace();
			request.setAttribute("errorMessage", "시스템 오류가 발생했습니다: " + e.getMessage());
			return "toiletAdd.jsp";
		}
	}
}