package com.emerlet.action;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public interface EmerletAction {
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
