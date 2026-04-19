package com.springmvc.controller;

import com.springmvc.dao.AddressDao;
import com.springmvc.dao.CustomerDao;
import com.springmvc.dao.UserDao;
import com.springmvc.model.Address;
import com.springmvc.model.Customer;
import com.springmvc.model.User;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    @Autowired private UserDao     userDao;
    @Autowired private CustomerDao customerDao;
    @Autowired private AddressDao  addressDao;

    private User getUser(HttpSession s) {
        return (User) s.getAttribute("loggedUser");
    }

    // ═══ XEM PROFILE ═══
    @GetMapping("")
    public String profile(HttpSession session, Model model) {
        User u = getUser(session);
        if (u == null) return "redirect:/login";
        Customer c = customerDao.findByUserId(u.getId());
        model.addAttribute("user",      u);
        model.addAttribute("customer",  c);
        model.addAttribute("addresses", addressDao.findByCustomerId(c.getId()));
        return "profile";
    }

    // ═══ CẬP NHẬT THÔNG TIN ═══
    @PostMapping("/update")
    public String updateInfo(
            @RequestParam(name = "name") String name,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String phone,
            HttpSession session, Model model) {

        User u = getUser(session);
        if (u == null) return "redirect:/login";
        Customer c = customerDao.findByUserId(u.getId());
        c.setName(name);
        c.setEmail(email);
        c.setPhone(phone);
        customerDao.updateInfo(c);
        session.setAttribute("loggedCustomer", customerDao.findByUserId(u.getId()));
        model.addAttribute("user",       u);
        model.addAttribute("customer",   customerDao.findByUserId(u.getId()));
        model.addAttribute("addresses",  addressDao.findByCustomerId(c.getId()));
        model.addAttribute("activeTab",  "info");
        model.addAttribute("infoSuccess","Cập nhật thông tin thành công!");
        return "profile";
    }

    // ═══ ĐỔI MẬT KHẨU ═══
    @PostMapping("/change-password")
    public String changePassword(
            @RequestParam(name = "currentPassword") String currentPassword,
            @RequestParam(name = "newPassword") String newPassword,
            @RequestParam(name = "confirmPassword") String confirmPassword,
            HttpSession session, Model model) {

        User u = getUser(session);
        if (u == null) return "redirect:/login";
        Customer c  = customerDao.findByUserId(u.getId());
        User dbUser = userDao.findById(u.getId());

        model.addAttribute("user",      u);
        model.addAttribute("customer",  c);
        model.addAttribute("addresses", addressDao.findByCustomerId(c.getId()));
        model.addAttribute("activeTab", "password");

        if (!BCrypt.checkpw(currentPassword, dbUser.getPassword())) {
            model.addAttribute("pwdError", "Mật khẩu hiện tại không đúng!");
            return "profile";
        }
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("pwdError", "Mật khẩu xác nhận không khớp!");
            return "profile";
        }
        if (newPassword.length() < 6) {
            model.addAttribute("pwdError", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            return "profile";
        }
        if (BCrypt.checkpw(newPassword, dbUser.getPassword())) {
            model.addAttribute("pwdError", "Mật khẩu mới không được trùng cũ!");
            return "profile";
        }
        String hashed = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        userDao.updatePassword(u.getId(), hashed);
        dbUser.setPassword(hashed);
        session.setAttribute("loggedUser", dbUser);
        model.addAttribute("pwdSuccess", "Đổi mật khẩu thành công!");
        return "profile";
    }

    // ═══ THÊM ĐỊA CHỈ ═══
    @PostMapping("/address/add")
    public String addAddress(
            @RequestParam(name = "fullName") String fullName,
            @RequestParam(name = "phone") String phone,
            @RequestParam(name = "address") String address,
            @RequestParam(required = false, defaultValue = "") String ward,
            @RequestParam(required = false, defaultValue = "") String district,
            @RequestParam(name = "city") String city,
            @RequestParam(required = false, defaultValue = "false") boolean isDefault,
            HttpSession session, RedirectAttributes ra) {

        User u = getUser(session);
        if (u == null) return "redirect:/login";
        Customer c = customerDao.findByUserId(u.getId());

        if (addressDao.countByCustomerId(c.getId()) == 0) isDefault = true;
        if (isDefault) addressDao.setDefault(-1, c.getId());

        Address a = new Address();
        a.setCustomerId(c.getId());
        a.setFullName(fullName);
        a.setPhone(phone);
        a.setAddress(address);
        a.setWard(ward);
        a.setDistrict(district);
        a.setCity(city);
        a.setDefault(isDefault);
        addressDao.save(a);

        ra.addFlashAttribute("addrSuccess", "Thêm địa chỉ thành công!");
        return "redirect:/profile#tab-address";
    }

    // ═══ SỬA ĐỊA CHỈ ═══
    @PostMapping("/address/edit/{id}")
    public String editAddress(
            @PathVariable int id,
            @RequestParam(name = "fullName") String fullName,
            @RequestParam(name = "phone") String phone,
            @RequestParam(name = "address") String address,
            @RequestParam(required = false, defaultValue = "") String ward,
            @RequestParam(required = false, defaultValue = "") String district,
            @RequestParam(name = "city") String city,
            HttpSession session, RedirectAttributes ra) {

        User u = getUser(session);
        if (u == null) return "redirect:/login";
        Address a = new Address();
        a.setId(id);
        a.setFullName(fullName);
        a.setPhone(phone);
        a.setAddress(address);
        a.setWard(ward);
        a.setDistrict(district);
        a.setCity(city);
        addressDao.update(a);

        ra.addFlashAttribute("addrSuccess", "Cập nhật địa chỉ thành công!");
        return "redirect:/profile#tab-address";
    }

    // ═══ ĐẶT MẶC ĐỊNH ═══
    @PostMapping("/address/default/{id}")
    public String setDefault(@PathVariable int id,
                             HttpSession session, RedirectAttributes ra) {
        User u = getUser(session);
        if (u == null) return "redirect:/login";
        Customer c = customerDao.findByUserId(u.getId());
        addressDao.setDefault(id, c.getId());
        ra.addFlashAttribute("addrSuccess", "Đã đặt làm địa chỉ mặc định!");
        return "redirect:/profile#tab-address";
    }

    // ═══ XOÁ ĐỊA CHỈ ═══
    @PostMapping("/address/delete/{id}")
    public String deleteAddress(@PathVariable int id,
                                HttpSession session, RedirectAttributes ra) {
        User u = getUser(session);
        if (u == null) return "redirect:/login";
        Customer c = customerDao.findByUserId(u.getId());
        boolean ok = addressDao.delete(id, c.getId());
        if (ok) ra.addFlashAttribute("addrSuccess", "Đã xoá địa chỉ!");
        else    ra.addFlashAttribute("addrError",
                    "Không thể xoá địa chỉ đang dùng trong đơn hàng.");
        return "redirect:/profile#tab-address";
    }
}
