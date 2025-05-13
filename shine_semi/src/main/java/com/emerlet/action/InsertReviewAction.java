package com.emerlet.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InsertReviewAction  implements EmerletAction {
    @Override
    public String pro(HttpServletRequest request, HttpServletResponse response) {
        return "insertReview.jsp";
    }
}
