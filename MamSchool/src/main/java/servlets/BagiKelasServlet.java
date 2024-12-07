import dao.BagiKelasDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
/**
 *
 * @author Raisa Lukman Hakim
 */
@WebServlet("/BagiKelasServlet")
public class BagiKelasServlet extends HttpServlet {

    private final BagiKelasDAO dao = new BagiKelasDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (action == null) {
            out.println("Invalid action!");
            return;
        }

        switch (action) {
            case "getTotalStudents":
                int totalStudents = dao.getTotalStudents();
                out.println("Total Students: " + totalStudents);
                break;

            case "getTotalStudentsWithClass":
                int totalWithClass = dao.getTotalStudentsWithClass();
                out.println("Total Students with Class: " + totalWithClass);
                break;

            case "listStudentsWithClass":
                dao.getStudentsWithClass().forEach(student -> out.println(student));
                break;

            case "listAllStudents":
                dao.getAllStudents().forEach(student -> out.println(student));
                break;

            case "listStudentsInClass":
                int classId = Integer.parseInt(request.getParameter("classId"));
                dao.getStudentsInClass().forEach(student -> out.println(student));
                break;

            default:
                out.println("Unknown action!");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (action == null) {
            out.println("Invalid action!");
            return;
        }

        switch (action) {
            case "assignStudentToClass":
                int studentId = Integer.parseInt(request.getParameter("studentId"));
                int classId = Integer.parseInt(request.getParameter("classId"));
                boolean assigned = dao.assignStudentToClass(studentId, classId);
                out.println(assigned ? "Student assigned successfully!" : "Failed to assign student.");
                break;

            case "addClass":
                String name = request.getParameter("name");
                String major = request.getParameter("major");
                boolean classAdded = dao.addClass(name, major);
                out.println(classAdded ? "Class added successfully!" : "Failed to add class.");
                break;

            default:
                out.println("Unknown action!");
        }
    }
}
