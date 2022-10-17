package controller.course;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import infrastructure.CourseDao;
import model.Course;

@WebServlet("/course-edit-form")
public class CourseEditFormServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CourseDao courseDAO;

	@Override
	public void init() {
		courseDAO = new CourseDao();
	}

    public CourseEditFormServelet() {
        super();
        
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("username")==null){
			response.sendRedirect("login");
		}
		else if(!session.getAttribute("role").equals("Admin")) {
			request.getRequestDispatcher("authorize-error.jsp").forward(request, response);
		}
		else {
			int id = Integer.parseInt(request.getParameter("id"));
			Course currentCourse;

			try {
				currentCourse = courseDAO.selectCourse(id);
				request.setAttribute("course", currentCourse);
				request.getRequestDispatcher("course-form.jsp").forward(request, response);
			} catch (SQLException e) {
				session.setAttribute("courseActionFailedMsg", e.getMessage());
				response.sendRedirect("courses");
			}
		}

	}

}
