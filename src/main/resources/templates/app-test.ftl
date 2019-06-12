package ${packageName};

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import com.domes.generatortools.doc.Swagger2MarkupConverter;

import java.io.BufferedWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
/**
 * ${classRemark}
 *
 * @author ${author}
 * @date ${date}
 */
@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
public class ${className} {

    @Autowired
    MockMvc mockMvc;

    @Test
    public void contextLoads() {

    }

    @Test
    public void generateDocTest() throws Exception {
        String outputDir = "doc/";
        MvcResult mvcResult = this.mockMvc.perform(MockMvcRequestBuilders.get("/v2/api-docs")
            .accept(MediaType.APPLICATION_JSON))
            .andExpect(MockMvcResultMatchers.status().isOk())
            .andReturn();

        MockHttpServletResponse response = mvcResult.getResponse();
        response.setCharacterEncoding("UTF-8");
        String swaggerJson = response.getContentAsString();
        Files.createDirectories(Paths.get(outputDir));
        try (BufferedWriter writer = Files.newBufferedWriter(Paths.get(outputDir, "swagger.json"))) {
            writer.write(swaggerJson);
        }
        Swagger2MarkupConverter converter = new Swagger2MarkupConverter(Paths.get(outputDir, "swagger.json"));
        converter.toFile(Paths.get(outputDir));
    }
}