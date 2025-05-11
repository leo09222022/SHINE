package com.emerlet.action;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emerlet.dao.ReviewDAO;
import com.emerlet.vo.ReviewVO;

public class InsertReviewOKAction {
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            ReviewVO vo = new ReviewVO();
            vo.setCleanliness(Integer.parseInt(request.getParameter("cleanliness")));
            vo.setSafety(Integer.parseInt(request.getParameter("safety")));
            vo.setSupplies(request.getParameter("supplies"));
            vo.setCreatedAt(new Date());

            String toiletId = request.getParameter("toiletId");
            String userToiletId = request.getParameter("userToiletId");

            if (toiletId != null && !toiletId.isEmpty()) {
                vo.setToiletId(Integer.parseInt(toiletId));
            } else {
                vo.setToiletId(0);
            }

            if (userToiletId != null && !userToiletId.isEmpty()) {
                vo.setUserToiletId(Integer.parseInt(userToiletId));
            } else {
                vo.setUserToiletId(0);
            }

            int result = new ReviewDAO().insertReview(vo);

            request.setAttribute("result", result);
            request.setAttribute("toiletId", toiletId);
            request.setAttribute("userToiletId", userToiletId);

            return "insertReviewOK.jsp";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:index.html";
        }
    }
}
