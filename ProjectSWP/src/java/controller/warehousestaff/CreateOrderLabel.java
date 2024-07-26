package controller.warehousestaff;

import Format.CurrencyFormatter;
import java.io.PrintWriter;
import jakarta.servlet.annotation.WebServlet;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.Font;
import dal.OrderDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import model.OrderDetail;
import model.Orders;
import com.itextpdf.text.Image;

@WebServlet(name = "CreateOrderLabel", urlPatterns = {"/createorderlabel"})
public class CreateOrderLabel extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CreateOrderLabel</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateOrderLabel at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        OrderDAO dao = new OrderDAO();
        response.setContentType("application/pdf");

        try {
            // Use a smaller page size
            Document document = new Document(PageSize.A6.rotate(), 0, 0, 60, 20);
            OutputStream out = response.getOutputStream();
            PdfWriter writer = PdfWriter.getInstance(document, out);
            writer.setPdfVersion(PdfWriter.VERSION_1_7);

            document.open();

            String fontPath = getServletContext().getRealPath("/fonts/arial.ttf");

            // Thay thế phần "/build/web/" trong đường dẫn bằng "/"
            String updatedFontPath = fontPath.replace("\\build\\web\\", "\\");

            if (updatedFontPath == null || updatedFontPath.isEmpty()) {
                throw new IOException("Font file not found");
            }

            BaseFont bf = BaseFont.createFont(updatedFontPath, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
            Font font = new Font(bf, 10);

            int orderID = 0;
            try {
                orderID = Integer.parseInt(request.getParameter("orderID"));
            } catch (Exception e) {
            }

            List<OrderDetail> listorderdetail = new ArrayList<>();
            Orders order = dao.getOrderByOrderIDWarehouse(orderID);
            listorderdetail = dao.getOrderDetailByOrderID(orderID);

            for (OrderDetail orderdetail : listorderdetail) {
                if (document.getPageNumber() > 1) {
                    document.newPage();
                }

                PdfPTable table = new PdfPTable(2);
                table.setWidthPercentage(70);
                table.setSpacingBefore(10f);
                table.setSpacingAfter(20f);

                addOrderInfoToTable(order, orderdetail, table, font);
                document.add(table);
            }

            document.close();
        } catch (DocumentException e) {
            throw new IOException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void addOrderInfoToTable(Orders order, OrderDetail detail, PdfPTable table, Font font) throws DocumentException, IOException {
        PdfPCell cell;

        // Header Logo
        Image logo = Image.getInstance(getServletContext().getRealPath("/images/LogoDiluri.png"));
        logo.scaleToFit(100, 50);
        cell = new PdfPCell(logo);
        cell.setBorder(PdfPCell.NO_BORDER);
        cell.setRowspan(8);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER); // Căn giữa logo
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE); // Căn giữa theo chiều dọc
        table.addCell(cell);

// Order Information
        cell = new PdfPCell(new Paragraph("Mã vận đơn: " + order.getOrderID(), font));
        cell.setBorder(PdfPCell.NO_BORDER);
        cell.setColspan(2); // Gộp các cột lại để phân bổ đều
        cell.setHorizontalAlignment(Element.ALIGN_LEFT); // Căn trái nội dung
        table.addCell(cell);

// Sender Information
        cell = new PdfPCell(new Paragraph("Người gửi: DiLuRi Sneaker Store", font));
        cell.setBorder(PdfPCell.NO_BORDER);
        cell.setColspan(2); // Gộp các cột lại để phân bổ đều
        cell.setHorizontalAlignment(Element.ALIGN_LEFT); // Căn trái nội dung
        table.addCell(cell);

// Receiver Information
        cell = new PdfPCell(new Paragraph("Người nhận: " + order.getReceiverName(), font));
        cell.setBorder(PdfPCell.NO_BORDER);
        cell.setColspan(2); // Gộp các cột lại để phân bổ đều
        cell.setHorizontalAlignment(Element.ALIGN_LEFT); // Căn trái nội dung
        table.addCell(cell);

        cell = new PdfPCell(new Paragraph("Địa chỉ người nhận: " + order.getReceiverAddress(), font));
        cell.setBorder(PdfPCell.NO_BORDER);
        cell.setColspan(2); // Gộp các cột lại để phân bổ đều
        cell.setHorizontalAlignment(Element.ALIGN_LEFT); // Căn trái nội dung
        table.addCell(cell);

// Order Details
        cell = new PdfPCell(new Paragraph("Nội dung hàng: " + detail.getTitle() + " - SL: " + detail.getQuantitySold(), font));
        cell.setBorder(PdfPCell.NO_BORDER);
        cell.setColspan(2); // Gộp các cột lại để phân bổ đều
        cell.setHorizontalAlignment(Element.ALIGN_LEFT); // Căn trái nội dung
        table.addCell(cell);

// Value and Date
        cell = new PdfPCell(new Paragraph("Giá trị: " + CurrencyFormatter.formatCurrency(order.getTotalCost()) + " VND", font));
        cell.setBorder(PdfPCell.NO_BORDER);
        cell.setColspan(2); // Gộp các cột lại để phân bổ đều
        cell.setHorizontalAlignment(Element.ALIGN_LEFT); // Căn trái nội dung
        table.addCell(cell);

        cell = new PdfPCell(new Paragraph("Ngày gửi hàng: " + order.getOrderDate(), font));
        cell.setBorder(PdfPCell.NO_BORDER);
        cell.setColspan(2); // Gộp các cột lại để phân bổ đều
        cell.setHorizontalAlignment(Element.ALIGN_LEFT); // Căn trái nội dung
        table.addCell(cell);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
