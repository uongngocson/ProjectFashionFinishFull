package local.example.demo.model.dto.facebook;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AttachmentData {
    private String description;
    private Media media;
    private Target target;
    private String type;
    private String url;
    private String title ;
}
