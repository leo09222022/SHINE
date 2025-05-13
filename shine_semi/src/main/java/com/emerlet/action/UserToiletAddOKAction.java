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

		  // 사용자의 언어 설정 가져오기 
        String lang = request.getParameter("lang"); 
        if (lang == null || lang.isEmpty()) {
            lang = "ko"; // 기본 언어 
        }

        
		try {
            
			request.setCharacterEncoding("UTF-8");

			UserToiletVO userToilet = new UserToiletVO();
			userToilet.setUserName(request.getParameter("userName"));
			userToilet.setUserRoadAddress(request.getParameter("userRoadAddress"));

			String maleToilet = request.getParameter("userMaleToilet");
			String femaleToilet = request.getParameter("userFemaleToilet");
			String maleDisabledToilet = request.getParameter("userMaleDisabledToilet");
			String hasDiaperTable = request.getParameter("userHasDiaperTable");
			String femaleDisabledToilet = request.getParameter("userFemaleDisabledToilet");
			String hasEmergencyBell = request.getParameter("userHasEmergencyBell");
			String hasCctv = request.getParameter("userHasCctv");


			// "모름" 선택 시 null 설정, 그렇지 않으면 값 그대로 설정
			userToilet.setUserMaleToilet("U".equals(maleToilet) ? null : maleToilet);
			userToilet.setUserFemaleToilet("U".equals(femaleToilet) ? null : femaleToilet);
			userToilet.setUserMaleDisabledToilet("U".equals(maleDisabledToilet) ? null : maleDisabledToilet);
			userToilet.setUserHasDiaperTable("U".equals(hasDiaperTable) ? null : hasDiaperTable);
			userToilet.setUserFemaleDisabledToilet("U".equals(femaleDisabledToilet) ? null : femaleDisabledToilet);
			userToilet.setUserHasEmergencyBell("U".equals(hasEmergencyBell) ? null : hasEmergencyBell);
			userToilet.setUserHasCctv("U".equals(hasCctv) ? null : hasCctv);
			userToilet.setUserDescription(request.getParameter("userDescription"));

			System.out.println("FormData: name=" + userToilet.getUserName());
			System.out.println("FormData: address=" + userToilet.getUserRoadAddress());
			System.out.println("FormData: maleToilet=" + userToilet.getUserMaleToilet());
			System.out.println("FormData: femaleToilet=" + userToilet.getUserFemaleToilet());
			System.out.println("FormData: disabledToilet=" + userToilet.getUserMaleDisabledToilet());
			System.out.println("FormData: hasDiaperTable=" + userToilet.getUserHasDiaperTable());

			try {
				String userLatStr = request.getParameter("userLat");
				String userLngStr = request.getParameter("userLng");

				System.out.println("Lat/Lng: " + userLatStr + ", " + userLngStr);

				if (userLatStr != null && !userLatStr.isEmpty() && userLngStr != null && !userLngStr.isEmpty()) {
					userToilet.setUserLat(Double.parseDouble(userLatStr));
					userToilet.setUserLng(Double.parseDouble(userLngStr));
				} else {
					request.setAttribute("message", "4");
					return "toiletAdd.jsp";
				}
			} catch (NumberFormatException e) {
				System.out.println("예외 발생: " + e.getMessage());
				return "toiletAdd.jsp";
			}

			// 파일 업로드 부분은 생략하고 photoUrl을 빈 문자열로 설정
			userToilet.setPhotoUrl("");

			UserToiletDAO userToiletDAO = new UserToiletDAO();
			int toiletId = userToiletDAO.addUserToilet(userToilet); 

			if (toiletId > 0) {
				ReviewVO review = new ReviewVO();

				review.setCleanliness(Integer.parseInt(request.getParameter("cleanliness")));
				review.setSafety(Integer.parseInt(request.getParameter("safety")));
				review.setUserToiletId(toiletId);
				review.setCreatedAt(new java.util.Date());

				ReviewDAO reviewDAO = new ReviewDAO();
				int result = reviewDAO.insertReview(review);
				boolean reviewResult = result > 0;

				System.out.println("리뷰 저장 결과: " + reviewResult);

				request.setAttribute("message", "1");
				return "toiletAddOK.jsp";
			} else {
				request.setAttribute("message", "2");
				return "toiletAdd.jsp";
			}
		} catch (Exception e) {
			System.out.println("예외 발생: " + e.getMessage());
			e.printStackTrace();
			request.setAttribute("message", String.format("3", e.getMessage()));
			return "toiletAdd.jsp";
		}
	}
}