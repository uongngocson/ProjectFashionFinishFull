package local.example.demo.controller.api;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import local.example.demo.model.dto.facebook.Post;
import local.example.demo.service.FacebookService;

import java.util.List;

@Controller
public class FacebookController {

    @Autowired
    private FacebookService facebookService;

    @GetMapping("/blog")
    public String showFacebookPosts(Model model) {
        List<Post> posts = facebookService.getPosts();
        model.addAttribute("posts", posts);
        return "client/layout/blog";
    }

    @PostMapping("/post-text")
    public String postTextToFacebook(@RequestParam("message") String message, Model model) {
        String response = facebookService.postTextToFacebook(message);
        model.addAttribute("response", response);
        return "redirect:/blog";
    }

    @PostMapping("/post-photo")
    public String postPhotoToFacebook(@RequestParam("message") String message,
                                      @RequestParam("file") MultipartFile file,
                                      Model model) {
        String response = facebookService.postPhotoToFacebook(message, file);
        model.addAttribute("response", response);
        return "redirect:/blog";
    }
}
