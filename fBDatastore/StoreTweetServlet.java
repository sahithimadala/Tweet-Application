package fBDatastore;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.users.*;
public class StoreTweetServlet extends HttpServlet
{
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		resp.setContentType("text/html");
		//PrintWriter pw=resp.getWriter();
		String uname = req.getParameter("uname");
		//pw.write(uname);
		HttpSession session = req.getSession(true);
		session.setAttribute("name",uname);
		
		RequestDispatcher rd = req.getRequestDispatcher("tweet.jsp");
			rd.forward(req, resp);
		
	}
	@SuppressWarnings("serial")
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
		resp.setContentType("text/html");
		//getting the datastore
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		//create entity Tweets and put the tweet message into the datastore
		String message=req.getParameter("message");
		String name=req.getParameter("Username");
		String uid=req.getParameter("UserId");
		String image = req.getParameter("image");
		Key tkey=KeyFactory.createKey("TweetID",name);
		Entity tweet=new Entity("Tweet",tkey);
		tweet.setProperty("TweetMessage",message);
		tweet.setProperty("Username",name);
		tweet.setProperty("usrID",uid);
		tweet.setProperty("picture",image);
		tweet.setProperty("visit_counter",0);
		datastore.put(tweet);
		resp.sendRedirect("tweet.jsp");
		

	}
}
