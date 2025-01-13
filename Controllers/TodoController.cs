using Microsoft.AspNetCore.Mvc;
using TodoAppBackend.Models;
using System.Collections.Generic;

[ApiController]
[Route("api/[controller]")]
public class TodoController : ControllerBase
{
    private static List<TodoItem> items = new List<TodoItem>();

    [HttpGet]
    public IActionResult Get() => Ok(items);

    [HttpPost]
    public IActionResult Post([FromBody] TodoItem item)
    {
        item.Id = items.Count + 1;
        items.Add(item);
        return CreatedAtAction(nameof(Get), new { id = item.Id }, item);
    }

    [HttpDelete("{id}")]
    public IActionResult Delete(int id)
    {
        var item = items.Find(i => i.Id == id);
        if (item == null) return NotFound();
        items.Remove(item);
        return NoContent();
    }
}
