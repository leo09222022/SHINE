package com.emerlet.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emerlet.dao.ReviewDAO;
import com.emerlet.vo.ReviewVO;

public class FindReviewAction {
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            Integer toiletId = null;
            Integer userToiletId = null;

            String toiletIdStr = request.getParameter("toiletId");
            String userToiletIdStr = request.getParameter("userToiletId");

            if (toiletIdStr != null && !toiletIdStr.isEmpty()) {
                toiletId = Integer.parseInt(toiletIdStr);
            }

            if (userToiletIdStr != null && !userToiletIdStr.isEmpty()) {
                userToiletId = Integer.parseInt(userToiletIdStr);
            }

            List<ReviewVO> reviews = new ReviewDAO().findReview(userToiletId, toiletId);

            request.setAttribute("reviews", reviews);

            return "findReview.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:index.html";
        }
    }
}
